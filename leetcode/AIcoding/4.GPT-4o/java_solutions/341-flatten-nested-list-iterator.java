import java.util.Iterator;
import java.util.List;
import java.util.Stack;

public class NestedIterator implements Iterator<Integer> {
    private Stack<Iterator<NestedInteger>> stack = new Stack<>();
    private Integer nextElement;

    public NestedIterator(List<NestedInteger> nestedList) {
        stack.push(nestedList.iterator());
        advance();
    }

    @Override
    public Integer next() {
        return nextElement;
    }

    @Override
    public boolean hasNext() {
        return nextElement != null;
    }

    private void advance() {
        nextElement = null;
        while (!stack.isEmpty()) {
            Iterator<NestedInteger> iterator = stack.peek();
            if (!iterator.hasNext()) {
                stack.pop();
                continue;
            }
            NestedInteger nestedInteger = iterator.next();
            if (nestedInteger.isInteger()) {
                nextElement = nestedInteger.getInteger();
                return;
            } else {
                stack.push(nestedInteger.getList().iterator());
            }
        }
    }
}