public class Solution {

import java.util.*;

public class Router {
    private final Map<String, Object> routes;

    public Router() {
        this.routes = new HashMap<>();
    }

    public void addRoute(String path, Object handler) {
        String[] parts = path.split("/");
        Map<String, Object> current = routes;
        for (int i = 1; i < parts.length; i++) {
            String part = parts[i];
            if (!current.containsKey(part)) {
                current.put(part, new HashMap<String, Object>());
            }
            current = (Map<String, Object>) current.get(part);
        }
        current.put("handler", handler);
    }

    public Object getHandler(String path) {
        String[] parts = path.split("/");
        Map<String, Object> current = routes;
        for (int i = 1; i < parts.length; i++) {
            String part = parts[i];
            if (!current.containsKey(part)) {
                return null;
            }
            current = (Map<String, Object>) current.get(part);
        }
        return current.get("handler");
    }
}
}