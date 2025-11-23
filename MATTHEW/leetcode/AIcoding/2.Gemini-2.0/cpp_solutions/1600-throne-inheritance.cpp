#include <string>
#include <vector>
#include <unordered_map>

class ThroneInheritance {
public:
    std::string kingName;
    std::unordered_map<std::string, std::vector<std::string>> children;
    std::unordered_map<std::string, bool> isAlive;

    ThroneInheritance(std::string kingName) {
        this->kingName = kingName;
        isAlive[kingName] = true;
    }

    void birth(std::string parentName, std::string childName) {
        children[parentName].push_back(childName);
        isAlive[childName] = true;
    }

    void death(std::string name) {
        isAlive[name] = false;
    }

    std::vector<std::string> getInheritanceOrder() {
        std::vector<std::string> order;
        dfs(kingName, order);
        return order;
    }

private:
    void dfs(std::string name, std::vector<std::string>& order) {
        if (isAlive[name]) {
            order.push_back(name);
        }

        for (std::string child : children[name]) {
            dfs(child, order);
        }
    }
};