class Solution {
public:
    bool checkIfPrecedes(string current, string previous) {
        if (current == previous) return false;
        if (current == "Qin") return true;
        if (current == "Han" && previous != "Qin") return true;
        if (current == "Sui" && previous != "Qin" && previous != "Han") return true;
        if (current == "Tang" && previous != "Qin" && previous != "Han" && previous != "Sui") return true;
        if (current == "Song" && previous != "Qin" && previous != "Han" && previous != "Sui" && previous != "Tang") return true;
        if (current == "Yuan" && previous != "Qin" && previous != "Han" && previous != "Sui" && previous != "Tang" && previous != "Song") return true;
        if (current == "Ming" && previous != "Qin" && previous != "Han" && previous != "Sui" && previous != "Tang" && previous != "Song" && previous != "Yuan") return true;
        if (current == "Qing" && previous != "Qin" && previous != "Han" && previous != "Sui" && previous != "Tang" && previous != "Song" && previous != "Yuan" && previous != "Ming") return true;
        return false;
    }

    bool checkOrder(vector<string>& dynasties) {
        for (int i = 1; i < dynasties.size(); i++) {
            if (!checkIfPrecedes(dynasties[i], dynasties[i - 1])) {
                return false;
            }
        }
        return true;
    }

    bool validateDyanstyOrder(vector<string>& dynasties) {
        return checkOrder(dynasties);
    }
};