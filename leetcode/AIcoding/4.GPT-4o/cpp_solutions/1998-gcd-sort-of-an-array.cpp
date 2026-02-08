#include <vector>
#include <algorithm>
#include <numeric>
#include <unordered_set>

class Solution {
public:
    bool gcdSort(std::vector<int>& nums) {
        int n = nums.size();
        std::vector<int> sorted = nums;
        std::sort(sorted.begin(), sorted.end());

        std::unordered_set<int> unique_nums(nums.begin(), nums.end());
        std::vector<int> gcds;

        for (int num : unique_nums) {
            for (int other : unique_nums) {
                if (num != other) {
                    gcds.push_back(std::gcd(num, other));
                }
            }
        }

        std::sort(gcds.begin(), gcds.end());
        gcds.erase(std::unique(gcds.begin(), gcds.end()), gcds.end());

        std::vector<int> visited(n, 0);
        for (int i = 0; i < n; i++) {
            if (visited[i]) continue;
            std::vector<int> component;
            std::vector<int> indices;
            dfs(i, nums, unique_nums, visited, component, indices);
            std::sort(component.begin(), component.end());
            std::sort(indices.begin(), indices.end());
            for (int j = 0; j < component.size(); j++) {
                nums[indices[j]] = component[j];
            }
        }

        return nums == sorted;
    }

private:
    void dfs(int index, std::vector<int>& nums, std::unordered_set<int>& unique_nums, std::vector<int>& visited, std::vector<int>& component, std::vector<int>& indices) {
        visited[index] = 1;
        component.push_back(nums[index]);
        indices.push_back(index);

        for (int next = 0; next < nums.size(); next++) {
            if (!visited[next] && std::gcd(nums[index], nums[next]) > 1) {
                dfs(next, nums, unique_nums, visited, component, indices);
            }
        }
    }
};