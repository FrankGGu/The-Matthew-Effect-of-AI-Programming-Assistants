class LRUCache {
public:
    LRUCache(int capacity) : cap(capacity) {}

    int get(int key) {
        if (mp.find(key) == mp.end()) return -1;
        update(key);
        return mp[key]->second;
    }

    void put(int key, int value) {
        if (mp.find(key) != mp.end()) {
            update(key);
            mp[key]->second = value;
        } else {
            if (mp.size() == cap) {
                mp.erase(lst.back().first);
                lst.pop_back();
            }
            lst.push_front({key, value});
            mp[key] = lst.begin();
        }
    }

private:
    int cap;
    list<pair<int, int>> lst;
    unordered_map<int, list<pair<int, int>>::iterator> mp;

    void update(int key) {
        lst.splice(lst.begin(), lst, mp[key]);
    }
};