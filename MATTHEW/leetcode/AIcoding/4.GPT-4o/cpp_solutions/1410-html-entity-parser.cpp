#include <string>
using namespace std;

class Solution {
public:
    string entityParser(string text) {
        string entities[5] = {"&quot;", "&apos;", "&amp;", "&gt;", "&lt;"};
        string replacements[5] = {"\"", "'", "&", ">", "<"};

        for (int i = 0; i < 5; i++) {
            size_t pos = 0;
            while ((pos = text.find(entities[i], pos)) != string::npos) {
                text.replace(pos, entities[i].length(), replacements[i]);
                pos += replacements[i].length();
            }
        }

        return text;
    }
};