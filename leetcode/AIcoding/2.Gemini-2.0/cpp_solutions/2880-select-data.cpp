#include <vector>
#include <string>

using namespace std;

struct Person {
    int id;
    string name;
    string city;
};

vector<Person> selectData(const vector<Person>& people) {
    vector<Person> result;
    for (const auto& person : people) {
        if (person.city == "New York") {
            result.push_back(person);
        }
    }
    return result;
}