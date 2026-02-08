import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class NestedIterator implements Iterator<Integer> {

    private List<Integer> flattenedList;
    private int currentIndex;

    public NestedIterator(List<NestedInteger> nestedList) {
        flattenedList = new ArrayList<>();
        flattenList(nestedList, flattenedList);
        currentIndex = 0;
    }

    private void flattenList(List<NestedInteger> nestedList, List<Integer> result) {
        for (NestedInteger ni : nestedList) {
            if (ni.isInteger()) {
                result.add(ni.getInteger());
            } else {
                flattenList(ni.getList(), result);
            }
        }
    }

    @Override
    public Integer next() {
        return flattenedList.get(currentIndex++);
    }

    @Override
    public boolean hasNext() {
        return currentIndex < flattenedList.size();
    }

    public interface NestedInteger {

        boolean isInteger();

        Integer getInteger();

        List<NestedInteger> getList();
    }
}