import java.util.ArrayList;
import java.util.List;

class BrowserHistory {
    private List<String> history;
    private int currentPointer;

    public BrowserHistory(String homepage) {
        history = new ArrayList<>();
        history.add(homepage);
        currentPointer = 0;
    }

    public void visit(String url) {
        currentPointer++;
        if (currentPointer < history.size()) {
            history.set(currentPointer, url);
            history.subList(currentPointer + 1, history.size()).clear();
        } else {
            history.add(url);
        }
    }

    public String back(int steps) {
        currentPointer = Math.max(0, currentPointer - steps);
        return history.get(currentPointer);
    }

    public String forward(int steps) {
        currentPointer = Math.min(history.size() - 1, currentPointer + steps);
        return history.get(currentPointer);
    }
}