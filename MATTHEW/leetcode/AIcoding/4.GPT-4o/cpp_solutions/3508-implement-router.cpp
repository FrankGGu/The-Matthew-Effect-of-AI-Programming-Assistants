class Router {
public:
    Router() {
        routes.clear();
    }

    void addRoute(string path, string handler) {
        routes[path] = handler;
    }

    string getRoute(string path) {
        if (routes.count(path)) {
            return routes[path];
        }
        return "404 Not Found";
    }

private:
    unordered_map<string, string> routes;
};