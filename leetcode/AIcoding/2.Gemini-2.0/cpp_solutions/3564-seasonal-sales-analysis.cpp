#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

struct Record {
    string product_id;
    string sale_date;
    int quantity;
};

vector<string> seasonalSales(vector<Record>& records) {
    unordered_map<string, int> product_sales;
    for (auto& record : records) {
        product_sales[record.product_id] += record.quantity;
    }

    vector<pair<string, int>> sales_vector(product_sales.begin(), product_sales.end());
    sort(sales_vector.begin(), sales_vector.end(), [](const auto& a, const auto& b) {
        if (a.second != b.second) {
            return a.second > b.second;
        } else {
            return a.first < b.first;
        }
    });

    vector<string> result;
    for (auto& pair : sales_vector) {
        result.push_back(pair.first);
    }

    return result;
}