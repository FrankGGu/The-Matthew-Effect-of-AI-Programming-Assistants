class Iterator {
public:
    Iterator(const vector<int>& nums) : data(nums), index(0) {}

    // Returns true if the iteration has more elements.
    bool hasNext() const {
        return index < data.size();
    }

    // Returns the next element in the iteration.
    int next() {
        return data[index++];
    }

private:
    vector<int> data;
    size_t index;
};

class PeekingIterator : public Iterator {
public:
    PeekingIterator(const vector<int>& nums) : Iterator(nums), hasPeeked(false) {}

    int peek() {
        if (!hasPeeked) {
            nextElement = Iterator::next();
            hasPeeked = true;
        }
        return nextElement;
    }

    int next() {
        if (hasPeeked) {
            hasPeeked = false;
            return nextElement;
        }
        return Iterator::next();
    }

    bool hasNext() const {
        return hasPeeked || Iterator::hasNext();
    }

private:
    bool hasPeeked;
    int nextElement;
};