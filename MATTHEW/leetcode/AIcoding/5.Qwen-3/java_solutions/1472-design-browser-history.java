public class Solution {

import java.util.Stack;

public class BrowserHistory {
    private Stack<String> backStack;
    private Stack<String> forwardStack;

    public BrowserHistory(String homepage) {
        backStack = new Stack<>();
        forwardStack = new Stack<>();
        backStack.push(homepage);
    }

    public void visit(String url) {
        backStack.push(url);
        forwardStack.clear();
    }

    public String back(int steps) {
        while (steps > 0 && backStack.size() > 1) {
            forwardStack.push(backStack.pop());
            steps--;
        }
        return backStack.peek();
    }

    public String forward(int steps) {
        while (steps > 0 && forwardStack.size() > 0) {
            backStack.push(forwardStack.pop());
            steps--;
        }
        return backStack.peek();
    }
}
}