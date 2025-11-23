#include <iostream>
#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    void addText(string text) {
        buffer += text;
    }

    int deleteText(int k) {
        int deleted = min(k, (int)buffer.size());
        buffer.erase(buffer.size() - deleted, deleted);
        return deleted;
    }

    string cursorLeft(int k) {
        int move = min(k, (int)cursorPos);
        cursorPos -= move;
        return buffer.substr(cursorPos, min(10, (int)buffer.size() - cursorPos));
    }

    string cursorRight(int k) {
        int move = min(k, (int)(buffer.size() - cursorPos));
        cursorPos += move;
        return buffer.substr(cursorPos, min(10, (int)buffer.size() - cursorPos));
    }

    string getText() {
        return buffer;
    }

private:
    string buffer;
    int cursorPos = 0;
};