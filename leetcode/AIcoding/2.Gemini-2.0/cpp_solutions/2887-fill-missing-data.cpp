#include <vector>
#include <string>

using namespace std;

struct Person {
    int id;
    string name;
};

vector<Person> fillMissingData(vector<Person>& persons) {
    for (auto& person : persons) {
        if (person.name.empty()) {
            person.name = "N/A";
        }
    }
    return persons;
}