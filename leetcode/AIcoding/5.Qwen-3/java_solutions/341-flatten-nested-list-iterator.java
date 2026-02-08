public class Solution {

import java.util.*;

public class NestedIterator implements Iterator<Integer> {
    private List<Integer> flatList;
    private int index;

    public NestedIterator(List<NestedInteger> nestedList) {
        flatList = new ArrayList<>();
        flatten(nestedList);
        index = 0;
    }

    private void flatten(List<NestedInteger> nestedList) {
        for (NestedInteger ni : nestedList) {
            if (ni.isInteger()) {
                flatList.add(ni.getInteger());
            } else {
                flatten(ni.getList());
            }
        }
    }

    @Override
    public Integer next() {
        return flatList.get(index++);
    }

    @Override
    public boolean hasNext() {
        return index < flatList.size();
    }
}

interface NestedInteger {
    boolean isInteger();
    Integer getInteger();
    List<NestedInteger> getList();
}
}