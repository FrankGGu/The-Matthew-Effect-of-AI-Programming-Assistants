class Solution {
public:
    int numberOfRounds(string loginTime, string logoutTime) {
        int login = stoi(loginTime.substr(0, 2)) * 60 + stoi(loginTime.substr(3, 2));
        int logout = stoi(logoutTime.substr(0, 2)) * 60 + stoi(logoutTime.substr(3, 2));

        if (logout < login) {
            logout += 24 * 60;
        }

        login = (login + 14) / 15 * 15;
        logout = logout / 15 * 15;

        return max(0, (logout - login) / 15);
    }
};