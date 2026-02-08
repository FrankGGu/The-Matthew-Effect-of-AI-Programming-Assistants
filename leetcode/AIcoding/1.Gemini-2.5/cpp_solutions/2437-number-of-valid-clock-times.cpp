class Solution {
public:
    int countValidTimes(std::string time) {
        int count = 0;

        for (int h = 0; h < 24; ++h) {
            for (int m = 0; m < 60; ++m) {
                // Check hours
                bool h_match = true;
                int h_tens = h / 10;
                int h_units = h % 10;

                if (time[0] != '?' && (time[0] - '0') != h_tens) {
                    h_match = false;
                }
                if (time[1] != '?' && (time[1] - '0') != h_units) {
                    h_match = false;
                }

                if (!h_match) {
                    continue;
                }

                // Check minutes
                bool m_match = true;
                int m_tens = m / 10;
                int m_units = m % 10;

                if (time[3] != '?' && (time[3] - '0') != m_tens) {
                    m_match = false;
                }
                if (time[4] != '?' && (time[4] - '0') != m_units) {
                    m_match = false;
                }

                if (m_match) {
                    count++;
                }
            }
        }

        return count;
    }
};