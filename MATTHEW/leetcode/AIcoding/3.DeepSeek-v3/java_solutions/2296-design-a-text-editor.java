class TextEditor {
    private StringBuilder left;
    private StringBuilder right;

    public TextEditor() {
        left = new StringBuilder();
        right = new StringBuilder();
    }

    public void addText(String text) {
        left.append(text);
    }

    public int deleteText(int k) {
        int actualDelete = Math.min(k, left.length());
        left.setLength(left.length() - actualDelete);
        return actualDelete;
    }

    public String cursorLeft(int k) {
        int move = Math.min(k, left.length());
        for (int i = 0; i < move; i++) {
            right.insert(0, left.charAt(left.length() - 1));
            left.deleteCharAt(left.length() - 1);
        }
        return left.substring(Math.max(0, left.length() - 10), left.length());
    }

    public String cursorRight(int k) {
        int move = Math.min(k, right.length());
        for (int i = 0; i < move; i++) {
            left.append(right.charAt(0));
            right.deleteCharAt(0);
        }
        return left.substring(Math.max(0, left.length() - 10), left.length());
    }
}