class TextEditor {
    StringBuilder text;
    int cursor;

    public TextEditor() {
        text = new StringBuilder();
        cursor = 0;
    }

    public void addText(String s) {
        text.insert(cursor, s);
        cursor += s.length();
    }

    public int deleteText(int k) {
        int deleteCount = Math.min(k, cursor);
        text.delete(cursor - deleteCount, cursor);
        cursor -= deleteCount;
        return deleteCount;
    }

    public String cursorLeft(int k) {
        cursor = Math.max(0, cursor - k);
        return getLeftText();
    }

    public String cursorRight(int k) {
        cursor = Math.min(text.length(), cursor + k);
        return getLeftText();
    }

    private String getLeftText() {
        return text.substring(Math.max(0, cursor - 10), cursor);
    }
}