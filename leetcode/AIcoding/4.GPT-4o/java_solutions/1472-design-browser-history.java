class BrowserHistory {

    private LinkedList<String> history;
    private int currentIndex;

    public BrowserHistory(String homepage) {
        history = new LinkedList<>();
        history.add(homepage);
        currentIndex = 0;
    }

    public void visit(String url) {
        while (history.size() > currentIndex + 1) {
            history.removeLast();
        }
        history.add(url);
        currentIndex++;
    }

    public String back(int steps) {
        currentIndex = Math.max(0, currentIndex - steps);
        return history.get(currentIndex);
    }

    public String forward(int steps) {
        currentIndex = Math.min(history.size() - 1, currentIndex + steps);
        return history.get(currentIndex);
    }
}