#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int numberOfRounds(std::string startTime, std::string endTime) {
        int startH = std::stoi(startTime.substr(0, 2));
        int startM = std::stoi(startTime.substr(3, 2));

        int endH = std::stoi(endTime.substr(0, 2));
        int endM = std::stoi(endTime.substr(3, 2));

        int totalStartMinutes = startH * 60 + startM;
        int totalEndMinutes = endH * 60 + endM;

        if (totalEndMinutes < totalStartMinutes) {
            totalEndMinutes += 24 * 60; // Add 24 hours if end time is on the next day
        }

        // Calculate the effective start minute for a full round
        // This is the smallest multiple of 15 that is >= totalStartMinutes
        int effectiveStartMinutes = (totalStartMinutes + 14) / 15 * 15;

        // Calculate the effective end minute for a full round
        // This is the largest multiple of 15 that is <= totalEndMinutes
        int effectiveEndMinutes = totalEndMinutes / 15 * 15;

        if (effectiveEndMinutes < effectiveStartMinutes) {
            return 0;
        }

        return (effectiveEndMinutes - effectiveStartMinutes) / 15;
    }
};