#include <string>
#include <vector>
#include <regex>

using namespace std;

#ifndef LEETCODE_SUBMISSION
#include <fstream>
#include <sstream>

#else
#include <algorithm>

#include <string>
#include <vector>

using namespace std;

vector<string> findValidEmails(vector<pair<int, string>> &customers,
                                  vector<tuple<int, string, string>> &contacts) {
  vector<string> valid_emails;
  for (const auto &contact : contacts) {
    int user_id = get<0>(contact);
    string contact_email = get<2>(contact);

    string customer_name;
    for (const auto &customer : customers) {
      if (customer.first == user_id) {
        customer_name = customer.second;
        break;
      }
    }

    string expected_email = "";
    transform(customer_name.begin(), customer_name.end(), customer_name.begin(),
              ::tolower);
    expected_email = customer_name + "@leetcode.com";

    if (contact_email == expected_email) {
      valid_emails.push_back(contact_email);
    }
  }
  return valid_emails;
}

#endif