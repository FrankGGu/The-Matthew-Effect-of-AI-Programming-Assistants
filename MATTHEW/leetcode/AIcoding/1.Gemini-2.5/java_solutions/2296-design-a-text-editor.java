class TextEditor {
    private StringBuilder left; // Characters to the left of the cursor
    private StringBuilder right; // Characters to the right of the cursor, stored in reverse order

    public TextEditor() {
        left = new StringBuilder();
        right = new StringBuilder();
    }

    public void addText(String text) {
        left.append(text);
    }

    public int deleteText(int k) {
        int deletedCount = Math.min(k, left.length());
        left.setLength(left.length() - deletedCount);
        return deletedCount;
    }

    public String cursorLeft(int k) {
        int numToMove = Math.min(k, left.length());
        for (int i = 0; i < numToMove; i++) {
            right.append(left.charAt(left.length() - 1));
            left.setLength(left.length() - 1);
        }

        int start = Math.max(0, left.length() - 10);
        return left.substring(start);
    }

    public String cursorRight(int k) {
        int numToMove = Math.min(k, right.length());
        for (int i = 0; i < numToMove; i++) {
            left.append(right.charAt(right.length() - 1));
            right.setLength(right.length() - 1);
        }

        int start = Math.max(0, left.length() - 10);
        return left.substring(start);
    }
}