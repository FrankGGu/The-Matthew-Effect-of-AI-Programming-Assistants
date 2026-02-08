class Router {
    private Map<String, String> routes;

    public Router() {
        routes = new HashMap<>();
    }

    public void addRoute(String path, String handler) {
        routes.put(path, handler);
    }

    public String getHandler(String path) {
        return routes.getOrDefault(path, "");
    }
}