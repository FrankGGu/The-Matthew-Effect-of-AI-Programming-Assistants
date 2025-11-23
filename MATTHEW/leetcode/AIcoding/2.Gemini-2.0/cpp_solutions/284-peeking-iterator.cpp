class PeekingIterator : public Iterator {
public:
	PeekingIterator(Iterator& iter) : Iterator(iter) {
		// Initialize any member here.
		// **DO NOT** save a copy of iter, either inside constructor or member functions.
		// The Iterator object is passed by reference as an argument to the constructor, and not copied.
		hasNext_ = Iterator::hasNext();
		if (hasNext_) {
			nextVal_ = Iterator::next();
		}
	}

	int peek() {
		return nextVal_;
	}

	int next() {
		int res = nextVal_;
		hasNext_ = Iterator::hasNext();
		if (hasNext_) {
			nextVal_ = Iterator::next();
		}
		return res;
	}

	bool hasNext() const {
		return hasNext_;
	}

private:
	int nextVal_;
	bool hasNext_;
};