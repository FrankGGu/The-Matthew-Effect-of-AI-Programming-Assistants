class TextEditor {
    StringBuilder text;
    Stack<String> history;

    public TextEditor() {
        text = new StringBuilder();
        history = new Stack<>();
    }

    public void addText(String text) {
        history.push(this.text.toString());
        this.text.append(text);
    }

    public int deleteText(int k) {
        history.push(this.text.toString());
        int deleteCount = Math.min(k, this.text.length());
        this.text.delete(this.text.length() - deleteCount, this.text.length());
        return deleteCount;
    }

    public String cursorLeft(int k) {
        int cursorPosition = Math.max(0, this.text.length() - k);
        return this.text.substring(cursorPosition, this.text.length());
    }

    public String cursorRight(int k) {
        int cursorPosition = Math.min(this.text.length(), this.text.length() + k);
        return this.text.substring(cursorPosition, this.text.length());
    }

    public String undo() {
        if (!history.isEmpty()) {
            this.text = new StringBuilder(history.pop());
        }
        return this.text.toString();
    }
}