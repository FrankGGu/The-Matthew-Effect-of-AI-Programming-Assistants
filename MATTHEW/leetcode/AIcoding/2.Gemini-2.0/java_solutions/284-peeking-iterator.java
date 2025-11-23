import java.util.Iterator;
import java.util.NoSuchElementException;

class PeekingIterator implements Iterator<Integer> {

    private Iterator<Integer> iterator;
    private Integer nextElement;

    public PeekingIterator(Iterator<Integer> iterator) {
        this.iterator = iterator;
        if (iterator.hasNext()) {
            nextElement = iterator.next();
        } else {
            nextElement = null;
        }
    }

    public Integer peek() {
        return nextElement;
    }

    @Override
    public Integer next() {
        if (nextElement == null) {
            throw new NoSuchElementException();
        }
        Integer result = nextElement;
        if (iterator.hasNext()) {
            nextElement = iterator.next();
        } else {
            nextElement = null;
        }
        return result;
    }

    @Override
    public boolean hasNext() {
        return nextElement != null;
    }
}