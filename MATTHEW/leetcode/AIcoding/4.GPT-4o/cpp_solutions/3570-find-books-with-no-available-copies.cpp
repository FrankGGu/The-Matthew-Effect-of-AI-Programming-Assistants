#include <vector>
#include <unordered_map>

class Solution {
public:
    std::vector<int> findBooksWithNoAvailableCopies(std::vector<int>& books, std::vector<int>& availableCopies) {
        std::unordered_map<int, int> bookCount;
        for (int book : books) {
            bookCount[book]++;
        }
        std::vector<int> result;
        for (int book : availableCopies) {
            if (bookCount[book] == 0) {
                result.push_back(book);
            }
        }
        return result;
    }
};