public class Solution {

class TextEditor {
    private final Deque<Character> left;
    private final Deque<Character> right;

    public TextEditor() {
        left = new LinkedList<>();
        right = new LinkedList<>();
    }

    public void addText(String text) {
        for (char c : text.toCharArray()) {
            left.addLast(c);
        }
    }

    public int deleteText(int k) {
        int deleted = 0;
        while (deleted < k && !left.isEmpty()) {
            left.removeLast();
            deleted++;
        }
        return deleted;
    }

    public String cursorLeft(int k) {
        int moved = 0;
        while (moved < k && !left.isEmpty()) {
            right.addFirst(left.removeLast());
            moved++;
        }
        StringBuilder sb = new StringBuilder();
        for (char c : left) {
            sb.append(c);
        }
        return sb.toString();
    }

    public String cursorRight(int k) {
        int moved = 0;
        while (moved < k && !right.isEmpty()) {
            left.addLast(right.removeFirst());
            moved++;
        }
        StringBuilder sb = new StringBuilder();
        for (char c : left) {
            sb.append(c);
        }
        return sb.toString();
    }
}
}