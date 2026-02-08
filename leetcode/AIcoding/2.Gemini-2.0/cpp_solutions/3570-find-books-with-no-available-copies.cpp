#include <vector>
#include <string>

using namespace std;

struct Book {
    int book_id;
    string name;
};

struct Orders {
    int order_id;
    int book_id;
    int quantity;
};

struct AvailableCopies {
    int book_id;
    int copies;
};

vector<int> findBooks(vector<Book>& books, vector<Orders>& orders, vector<AvailableCopies>& availableCopies) {
    vector<int> result;
    vector<int> available_book_ids;

    for (auto& ac : availableCopies) {
        available_book_ids.push_back(ac.book_id);
    }

    for (auto& book : books) {
        bool found_in_available = false;
        for (auto& ac : availableCopies) {
            if (ac.book_id == book.book_id) {
                found_in_available = true;
                break;
            }
        }

        if (!found_in_available) {
            result.push_back(book.book_id);
        }
    }

    return result;
}