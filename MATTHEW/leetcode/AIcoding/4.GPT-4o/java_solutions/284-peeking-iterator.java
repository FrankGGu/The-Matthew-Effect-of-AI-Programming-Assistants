class PeekingIterator implements Iterator<Integer> {
    private Iterator<Integer> iterator;
    private Integer nextElement;

    public PeekingIterator(Iterator<Integer> iterator) {
        this.iterator = iterator;
        if (iterator.hasNext()) {
            nextElement = iterator.next();
        }
    }

    public Integer peek() {
        return nextElement;
    }

    @Override
    public Integer next() {
        Integer toReturn = nextElement;
        nextElement = iterator.hasNext() ? iterator.next() : null;
        return toReturn;
    }

    @Override
    public boolean hasNext() {
        return nextElement != null;
    }
}