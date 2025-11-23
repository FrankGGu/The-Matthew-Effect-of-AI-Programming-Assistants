import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

class Router {

    private final RouterNode root;

    public Router() {
        root = new RouterNode();
    }

    // A simple Handler class. In a real application, this would likely be an interface
    // or a functional interface for more complex logic.
    public static class Handler {
        private String name; 

        public Handler(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return "Handler(" + name + ")";
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Handler handler = (Handler) o;
            return Objects.equals(name, handler.name);
        }

        @Override
        public int hashCode() {
            return Objects.hash(name);
        }
    }

    private static class RouterNode {
        Map<String, RouterNode> children; // For exact segment matches
        RouterNode paramChild;          // For path parameter segments like {id}
        String paramName;               // Stores the name of the path parameter (e.g., "id")
        RouterNode wildcardChild;       // For a trailing wildcard '*'
        Object handler;                 // The handler registered for the path ending at this node
        int specificity;                // Specificity score of the path ending at this node

        RouterNode() {
            children = new HashMap<>();
            handler = null;
            specificity = -1; // -1 indicates no handler registered at this node
        }
    }

    // MatchResult encapsulates the matched handler, extracted path parameters, and the specificity score.
    public static class MatchResult {
        public Object handler;
        public Map<String, String> pathParams;
        public int specificity; // Specificity of the matched path

        public MatchResult(Object handler, Map<String, String> pathParams, int specificity) {
            this.handler = handler;
            this.pathParams = pathParams;
            this.specificity = specificity;
        }
    }

    public void register(String path, Object handler) {
        if (path == null || path.isEmpty() || !path.startsWith("/")) {
            throw new IllegalArgumentException("Invalid path: " + path);
        }

        String[] segments = path.substring(1).split("/");
        if (segments.length == 1 && segments[0].isEmpty()) { // Handle root path "/"
            segments = new String[0];
        }

        RouterNode current = root;
        int currentSpecificity = 0;

        for (int i = 0; i < segments.length; i++) {
            String segment = segments[i];

            if (segment.startsWith("{") && segment.endsWith("}")) { // Path parameter segment
                if (current.paramChild == null) {
                    current.paramChild = new RouterNode();
                    current.paramChild.paramName = segment.substring(1, segment.length() - 1);
                }
                current = current.paramChild;
                currentSpecificity += 2; // Path parameter is less specific than exact match
            } else if (segment.equals("*")) { // Wildcard segment
                if (i != segments.length - 1) {
                    throw new IllegalArgumentException("Wildcard '*' can only be at the end of a path: " + path);
                }
                if (current.wildcardChild == null) {
                    current.wildcardChild = new RouterNode();
                }
                current = current.wildcardChild;
                currentSpecificity += 1; // Wildcard is the least specific
            } else { // Exact segment
                current = current.children.computeIfAbsent(segment, k -> new RouterNode());
                currentSpecificity += 3; // Exact match is the most specific
            }
        }

        current.handler = handler;
        current.specificity = currentSpecificity;
    }

    public MatchResult dispatch(String requestPath) {
        if (requestPath == null || requestPath.isEmpty() || !requestPath.startsWith("/")) {
            return null;
        }

        String[] segments = requestPath.substring(1).split("/");
        if (segments.length == 1 && segments[0].isEmpty()) { // Handle root path "/"
            segments = new String[0];
        }

        return findBestMatchRecursive(root, segments, 0, new HashMap<>(), null);
    }

    private MatchResult findBestMatchRecursive(RouterNode node, String[] requestSegments, int segmentIndex,
                                               Map<String, String> currentPathParams,
                                               MatchResult bestMatchSoFar) {

        // If all request segments have been processed
        if (segmentIndex == requestSegments.length) {
            // Check if the current node itself has a handler
            if (node.handler != null && node.specificity >= 0) {
                if (bestMatchSoFar == null || node.specificity > bestMatchSoFar.specificity) {
                    bestMatchSoFar = new MatchResult(node.handler, new HashMap<>(currentPathParams), node.specificity);
                }
            }
            // Also, consider if a wildcard handler is registered at this node (e.g., /a/* matching /a)
            // This assumes '*' matches zero or more segments.
            if (node.wildcardChild != null && node.wildcardChild.handler != null && node.wildcardChild.specificity >= 0) {
                if (bestMatchSoFar == null || node.wildcardChild.specificity > bestMatchSoFar.specificity) {
                    bestMatchSoFar = new MatchResult(node.wildcardChild.handler, new HashMap<>(currentPathParams), node.wildcardChild.specificity);
                }
            }
            return bestMatchSoFar;
        }

        String currentRequestSegment = requestSegments[segmentIndex];

        // 1. Try exact match
        RouterNode exactChild = node.children.get(currentRequestSegment);
        if (exactChild != null) {
            bestMatchSoFar = findBestMatchRecursive(exactChild, requestSegments, segmentIndex + 1, currentPathParams, bestMatchSoFar);
        }

        // 2. Try path parameter match
        if (node.paramChild != null) {
            Map<String, String> nextPathParams = new HashMap<>(currentPathParams);
            nextPathParams.put(node.paramChild.paramName, currentRequestSegment);
            bestMatchSoFar = findBestMatchRecursive(node.paramChild, requestSegments, segmentIndex + 1, nextPathParams, bestMatchSoFar);
        }

        // 3. Try wildcard match (if a wildcard handler is registered at this node for the rest of the path)
        // This means a path like `/a/*` was registered, and we are at the `node` for `/a`.
        // The wildcard handler is a candidate for the rest of the `requestSegments` from `segmentIndex` onwards.
        if (node.wildcardChild != null && node.wildcardChild.handler != null && node.wildcardChild.specificity >= 0) {
            if (bestMatchSoFar == null || node.wildcardChild.specificity > bestMatchSoFar.specificity) {
                bestMatchSoFar = new MatchResult(node.wildcardChild.handler, new HashMap<>(currentPathParams), node.wildcardChild.specificity);
            }
        }

        return bestMatchSoFar;
    }
}