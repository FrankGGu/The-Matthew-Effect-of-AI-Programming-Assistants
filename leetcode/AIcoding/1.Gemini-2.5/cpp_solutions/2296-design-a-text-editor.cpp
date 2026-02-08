#include <string>
#include <algorithm> // For std::min and std::max

class TextEditor {
private:
    std::string left_part;
    std::string right_part; // Stores characters to the right of the cursor, in reverse order

public:
    TextEditor() {
        left_part = "";
        right_part = "";
    }

    void addText(std::string text) {
        left_part.append(text);
    }

    int deleteText(int k) {
        int chars_to_delete = std::min((int)left_part.length(), k);
        left_part.resize(left_part.length() - chars_to_delete);
        return chars_to_delete;
    }

    std::string cursorLeft(int k) {
        int chars_to_move = std::min((int)left_part.length(), k);
        if (chars_to_move > 0) {
            right_part.append(left_part.substr(left_part.length() - chars_to_move));
            left_part.resize(left_part.length() - chars_to_move);
        }

        int start_index = std::max(0, (int)left_part.length() - 10);
        return left_part.substr(start_index);
    }

    std::string cursorRight(int k) {
        int chars_to_move = std::min((int)right_part.length(), k);
        if (chars_to_move > 0) {
            left_part.append(right_part.substr(right_part.length() - chars_to_move));
            right_part.resize(right_part.length() - chars_to_move);
        }

        int start_index = std::max(0, (int)left_part.length() - 10);
        return left_part.substr(start_index);
    }
};