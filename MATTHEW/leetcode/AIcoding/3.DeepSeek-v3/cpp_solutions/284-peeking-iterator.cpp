class PeekingIterator : public Iterator {
private:
    int peekedValue;
    bool hasPeeked;
public:
	PeekingIterator(const vector<int>& nums) : Iterator(nums) {
	    hasPeeked = false;
	}

	int peek() {
        if (!hasPeeked) {
            peekedValue = Iterator::next();
            hasPeeked = true;
        }
        return peekedValue;
	}

	int next() {
	    if (hasPeeked) {
            hasPeeked = false;
            return peekedValue;
        }
        return Iterator::next();
	}

	bool hasNext() const {
	    return hasPeeked || Iterator::hasNext();
	}
};