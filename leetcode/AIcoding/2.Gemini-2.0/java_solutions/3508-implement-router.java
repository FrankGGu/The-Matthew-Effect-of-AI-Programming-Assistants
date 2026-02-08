import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class Router {

    private Map<String, Handler> routes;

    public Router() {
        routes = new HashMap<>();
    }

    public void addRoute(String path, Handler handler) {
        routes.put(path, handler);
    }

    public Handler route(String path) {
        for (String routePath : routes.keySet()) {
            if (routePath.equals(path)) {
                return routes.get(routePath);
            } else if (routePath.contains("{") && routePath.contains("}")) {
                String regex = routePath.replaceAll("\\{.*?\\}", "([^/]+)");
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(path);
                if (matcher.matches()) {
                    return routes.get(routePath);
                }
            }
        }
        return null;
    }

    interface Handler {
        void handle();
    }
}