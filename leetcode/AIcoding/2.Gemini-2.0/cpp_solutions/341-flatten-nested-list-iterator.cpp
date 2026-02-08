class NestedIterator {
private:
    vector<int> flattenedList;
    int currentIndex;

public:
    NestedIterator(vector<NestedInteger> &nestedList) {
        flattenList(nestedList);
        currentIndex = 0;
    }

    void flattenList(vector<NestedInteger> &nestedList) {
        for (NestedInteger &nestedInteger : nestedList) {
            if (nestedInteger.isInteger()) {
                flattenedList.push_back(nestedInteger.getInteger());
            } else {
                flattenList(nestedInteger.getList());
            }
        }
    }

    int next() {
        return flattenedList[currentIndex++];
    }

    bool hasNext() {
        return currentIndex < flattenedList.size();
    }
};