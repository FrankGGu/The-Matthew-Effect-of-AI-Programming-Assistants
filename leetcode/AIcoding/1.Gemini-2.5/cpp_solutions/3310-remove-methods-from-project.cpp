#include <vector>
#include <string>
#include <algorithm>
#include <unordered_set>
#include <utility>

struct Method {
    std::string name;
    // Add other method properties here if necessary for the problem,
    // but for removal by name, only 'name' is strictly needed.
    Method(std::string n) : name(std::move(n)) {}
};

struct Project {
    std::string name;
    std::vector<Method> methods;
    // Constructors for convenience
    Project(std::string n) : name(std::move(n)) {}
    Project(std::string n, std::vector<Method> m) : name(std::move(n)), methods(std::move(m)) {}
};

class Solution {
public:
    void removeMethods(Project& project, const std::vector<std::string>& methodsToRemove) {
        std::unordered_set<std::string> methodsToRemoveSet(methodsToRemove.begin(), methodsToRemove.end());

        project.methods.erase(
            std::remove_if(project.methods.begin(), project.methods.end(),
                           [&](const Method& m) {
                               return methodsToRemoveSet.count(m.name) > 0;
                           }),
            project.methods.end());
    }
};