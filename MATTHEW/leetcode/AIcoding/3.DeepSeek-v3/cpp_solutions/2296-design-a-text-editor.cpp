class TextEditor {
private:
    string left;
    string right;

public:
    TextEditor() {
        left = "";
        right = "";
    }

    void addText(string text) {
        left += text;
    }

    int deleteText(int k) {
        int actual = min(k, (int)left.size());
        left.erase(left.size() - actual, actual);
        return actual;
    }

    string cursorLeft(int k) {
        int move = min(k, (int)left.size());
        right.insert(right.begin(), left.end() - move, left.end());
        left.erase(left.end() - move, left.end());
        int len = min(10, (int)left.size());
        return left.substr(left.size() - len, len);
    }

    string cursorRight(int k) {
        int move = min(k, (int)right.size());
        left.insert(left.end(), right.begin(), right.begin() + move);
        right.erase(right.begin(), right.begin() + move);
        int len = min(10, (int)left.size());
        return left.substr(left.size() - len, len);
    }
};