import java.util.Deque;
import java.util.ArrayDeque;

class Solution {
    public String simplifyPath(String path) {
        Deque<String> stack = new ArrayDeque<>();
        String[] components = path.split("/");

        for (String component : components) {
            if (component.equals("") || component.equals(".")) {
                continue;
            } else if (component.equals("..")) {
                if (!stack.isEmpty()) {
                    stack.pop();
                }
            } else {
                stack.push(component);
            }
        }

        if (stack.isEmpty()) {
            return "/";
        }

        StringBuilder simplifiedPath = new StringBuilder();
        while (!stack.isEmpty()) {
            simplifiedPath.insert(0, stack.pop());
            simplifiedPath.insert(0, "/");
        }

        return simplifiedPath.toString();
    }
}