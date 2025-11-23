class Solution {
public:
    bool isValidSerialization(string preorder) {
        int slots = 1;
        string delimiter = ",";
        size_t pos = 0;
        string token;
        while ((pos = preorder.find(delimiter)) != string::npos) {
            token = preorder.substr(0, pos);
            preorder.erase(0, pos + delimiter.length());
            slots--;
            if (slots < 0) return false;
            if (token != "#") slots += 2;
        }
        slots--;
        if (slots < 0) return false;
        if (preorder != "#") slots += 2;
        return slots == 0;
    }
};