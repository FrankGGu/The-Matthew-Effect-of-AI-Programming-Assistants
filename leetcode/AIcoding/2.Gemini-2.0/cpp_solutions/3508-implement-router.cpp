#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Router {
public:
    Router() {}

    void addRoute(const string& route, int id) {
        routes[route] = id;
    }

    int route(const string& path) {
        for (const auto& entry : routes) {
            const string& route = entry.first;
            int id = entry.second;

            if (route == path) {
                return id;
            }

            if (route.back() == '*' && path.size() >= route.size() - 1 &&
                path.substr(0, route.size() - 1) == route.substr(0, route.size() - 1)) {
                return id;
            }
        }
        return -1;
    }

private:
    unordered_map<string, int> routes;
};