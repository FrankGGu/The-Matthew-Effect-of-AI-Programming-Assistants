class RandomizedSet {
public:
    unordered_map<int, int> index_map;
    vector<int> elements;

    RandomizedSet() {
    }

    bool insert(int val) {
        if (index_map.count(val)) return false;
        index_map[val] = elements.size();
        elements.push_back(val);
        return true;
    }

    bool remove(int val) {
        if (!index_map.count(val)) return false;
        int last_element = elements.back();
        int idx = index_map[val];
        index_map[last_element] = idx;
        elements[idx] = last_element;
        elements.pop_back();
        index_map.erase(val);
        return true;
    }

    int getRandom() {
        return elements[rand() % elements.size()];
    }
};