class BrowserHistory {

    private Stack<String> history;
    private Stack<String> future;
    private String current;

    public BrowserHistory(String homepage) {
        history = new Stack<>();
        future = new Stack<>();
        current = homepage;
    }

    public void visit(String url) {
        history.push(current);
        current = url;
        future.clear();
    }

    public String back(int steps) {
        while (steps > 0 && !history.isEmpty()) {
            future.push(current);
            current = history.pop();
            steps--;
        }
        return current;
    }

    public String forward(int steps) {
        while (steps > 0 && !future.isEmpty()) {
            history.push(current);
            current = future.pop();
            steps--;
        }
        return current;
    }
}