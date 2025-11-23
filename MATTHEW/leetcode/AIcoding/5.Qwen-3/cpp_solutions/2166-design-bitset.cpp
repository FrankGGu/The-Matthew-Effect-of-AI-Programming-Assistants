#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    Solution(int size);
    void fix(int idx);
    void unfix(int idx);
    void flip();
    bool all();
    bool one();
    int count();
    string toString();

private:
    vector<bool> bits;
    int size;
    int countSet;
};

Solution::Solution(int size) : size(size), countSet(0) {
    bits.resize(size, false);
}

void Solution::fix(int idx) {
    if (!bits[idx]) {
        bits[idx] = true;
        countSet++;
    }
}

void Solution::unfix(int idx) {
    if (bits[idx]) {
        bits[idx] = false;
        countSet--;
    }
}

void Solution::flip() {
    for (int i = 0; i < size; ++i) {
        bits[i] = !bits[i];
    }
    countSet = size - countSet;
}

bool Solution::all() {
    return countSet == size;
}

bool Solution::one() {
    return countSet > 0;
}

int Solution::count() {
    return countSet;
}

string Solution::toString() {
    string result;
    for (bool bit : bits) {
        result += bit ? '1' : '0';
    }
    return result;
}