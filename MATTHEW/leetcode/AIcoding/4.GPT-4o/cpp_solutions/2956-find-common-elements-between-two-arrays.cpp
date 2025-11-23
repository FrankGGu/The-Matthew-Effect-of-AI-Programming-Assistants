#include <vector>
#include <unordered_set>
#include <algorithm>

std::vector<int> findCommonElements(std::vector<int>& arr1, std::vector<int>& arr2) {
    std::unordered_set<int> set1(arr1.begin(), arr1.end());
    std::unordered_set<int> commonElements;

    for (int num : arr2) {
        if (set1.count(num)) {
            commonElements.insert(num);
        }
    }

    return std::vector<int>(commonElements.begin(), commonElements.end());
}