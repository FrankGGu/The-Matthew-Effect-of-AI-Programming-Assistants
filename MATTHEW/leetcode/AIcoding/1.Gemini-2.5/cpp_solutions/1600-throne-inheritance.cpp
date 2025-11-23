#include <string>
#include <vector>
#include <unordered_map>
#include <unordered_set>

class ThroneInheritance {
private:
    std::string kingName;
    std::unordered_map<std::string, std::vector<std::string>> familyTree;
    std::unordered_set<std::string> deceased;

    void dfs(const std::string& currentPerson, std::vector<std::string>& order) {
        if (deceased.count(currentPerson)) {
            return;
        }
        order.push_back(currentPerson);

        auto it = familyTree.find(currentPerson);
        if (it != familyTree.end()) {
            for (const std::string& child : it->second) {
                dfs(child, order);
            }
        }
    }

public:
    ThroneInheritance(std::string kingName) {
        this->kingName = kingName;
    }

    void birth(std::string parentName, std::string childName) {
        familyTree[parentName].push_back(childName);
    }

    void death(std::string name) {
        deceased.insert(name);
    }

    std::vector<std::string> getInheritanceOrder() {
        std::vector<std::string> order;
        dfs(kingName, order);
        return order;
    }
};