class TextEditor {
public:
    string text;
    int cursor;

    TextEditor() : cursor(0) {}

    void addText(string text) {
        this->text.insert(cursor, text);
        cursor += text.size();
    }

    int deleteText(int k) {
        int deleted = min(k, cursor);
        text.erase(cursor - deleted, deleted);
        cursor -= deleted;
        return deleted;
    }

    string cursorLeft(int k) {
        cursor = max(0, cursor - k);
        return getCurrentText(10);
    }

    string cursorRight(int k) {
        cursor = min((int)text.size(), cursor + k);
        return getCurrentText(10);
    }

private:
    string getCurrentText(int len) {
        return text.substr(max(0, cursor - len), min(len, cursor));
    }
};