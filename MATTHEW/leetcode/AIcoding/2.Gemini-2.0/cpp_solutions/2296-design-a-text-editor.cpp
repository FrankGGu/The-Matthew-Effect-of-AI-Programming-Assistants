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
        int deleted = min((int)left.length(), k);
        left.erase(left.length() - deleted, deleted);
        return deleted;
    }

    string cursorLeft(int k) {
        int move = min((int)left.length(), k);
        right = left.substr(left.length() - move, move) + right;
        left.erase(left.length() - move, move);
        return left.length() >= 10 ? left.substr(left.length() - 10, 10) : left;
    }

    string cursorRight(int k) {
        int move = min((int)right.length(), k);
        left += right.substr(0, move);
        right.erase(0, move);
        return left.length() >= 10 ? left.substr(left.length() - 10, 10) : left;
    }

    string cursorHome() {
        right = left + right;
        left = "";
        return left;
    }

    string cursorEnd() {
        left += right;
        right = "";
        return left.length() >= 10 ? left.substr(left.length() - 10, 10) : left;
    }
};