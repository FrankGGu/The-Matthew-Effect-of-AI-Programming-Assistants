import java.util.Iterator;
import java.util.NoSuchElementException;

class PeekingIterator implements Iterator<Integer> {
    private Iterator<Integer> iterator;
    private Integer nextElement;
    private boolean hasPeeked;

    public PeekingIterator(Iterator<Integer> iterator) {
        this.iterator = iterator;
        this.nextElement = null;
        this.hasPeeked = false;
    }

    public Integer peek() {
        if (!hasPeeked) {
            if (!iterator.hasNext()) {
                throw new NoSuchElementException();
            }
            nextElement = iterator.next();
            hasPeeked = true;
        }
        return nextElement;
    }

    @Override
    public Integer next() {
        if (!hasNext()) {
            throw new NoSuchElementException();
        }

        if (hasPeeked) {
            Integer result = nextElement;
            nextElement = null;
            hasPeeked = false;
            return result;
        } else {
            return iterator.next();
        }
    }

    @Override
    public boolean hasNext() {
        return hasPeeked || iterator.hasNext();
    }
}