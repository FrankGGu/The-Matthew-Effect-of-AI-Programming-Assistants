#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

struct Book {
    int book_id;
    std::string title;
};

struct Copy {
    int copy_id;
    int book_id;
    std::string status; // e.g., "available", "borrowed", "lost"
};

class Solution {
public:
    std::vector<Book> findBooksWithNoAvailableCopies(std::vector<Book>& books, std::vector<Copy>& copies) {
        std::unordered_set<int> book_ids_with_available_copies;

        for (const auto& copy : copies) {
            if (copy.status == "available") {
                book_ids_with_available_copies.insert(copy.book_id);
            }
        }

        std::vector<Book> result;
        for (const auto& book : books) {
            if (book_ids_with_available_copies.find(book.book_id) == book_ids_with_available_copies.end()) {
                result.push_back(book);
            }
        }

        return result;
    }
};