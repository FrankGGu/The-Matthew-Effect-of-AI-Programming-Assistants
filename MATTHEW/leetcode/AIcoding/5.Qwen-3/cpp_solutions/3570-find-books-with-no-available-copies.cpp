#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> findBooksNoAvailableCopies(vector<string> books, vector<int> copies) {
        vector<string> result;
        for (int i = 0; i < books.size(); ++i) {
            if (copies[i] == 0) {
                result.push_back(books[i]);
            }
        }
        return result;
    }
};