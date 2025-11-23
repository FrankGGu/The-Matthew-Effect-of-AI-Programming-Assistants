public class Solution {

import java.util.Iterator;

public class PeekingIterator implements Iterator<Integer> {
    private Iterator<Integer> iterator;
    private Integer peekedElement;

    public PeekingIterator(Iterator<Integer> iterator) {
        this.iterator = iterator;
        this.peekedElement = null;
    }

    public Integer peek() {
        if (peekedElement == null) {
            peekedElement = iterator.next();
        }
        return peekedElement;
    }

    @Override
    public boolean hasNext() {
        return peekedElement != null || iterator.hasNext();
    }

    @Override
    public Integer next() {
        if (peekedElement != null) {
            Integer result = peekedElement;
            peekedElement = null;
            return result;
        }
        return iterator.next();
    }
}
}