#include <string>
#include <vector>
#include <map>
#include <limits>
#include <utility> // For std::pair

class Router {
private:
    std::map<std::pair<int, int>, std::string> routes;

public:
    Router() {
        // Constructor, no specific initialization needed for the map
    }

    void addRoute(int startIp, int endIp, std::string gatewayIp) {
        routes[{startIp, endIp}] = gatewayIp;
    }

    void removeRoute(int startIp, int endIp) {
        routes.erase({startIp, endIp});
    }

    std::string route(int ip) {
        std::string bestGateway = "";
        int minRangeSize = std::numeric_limits<int>::max();

        for (const auto& entry : routes) {
            int start = entry.first.first;
            int end = entry.first.second;
            std::string gateway = entry.second;

            if (start <= ip && ip <= end) {
                int currentRangeSize = end - start + 1;
                if (bestGateway == "" || currentRangeSize < minRangeSize) {
                    minRangeSize = currentRangeSize;
                    bestGateway = gateway;
                }
            }
        }
        return bestGateway;
    }
};