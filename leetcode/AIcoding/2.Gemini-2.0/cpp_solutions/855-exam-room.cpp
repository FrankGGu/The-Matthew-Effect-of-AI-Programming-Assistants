#include <set>

class ExamRoom {
public:
    ExamRoom(int n) : N(n) {}

    int seat() {
        if (students.empty()) {
            students.insert(0);
            return 0;
        }

        int dist = *students.begin();
        int pos = 0;

        auto it = students.begin();
        while (next(it) != students.end()) {
            int d = (*next(it) - *it) / 2;
            if (d > dist) {
                dist = d;
                pos = *it + d;
            }
            it++;
        }

        if (N - 1 - *students.rbegin() > dist) {
            pos = N - 1;
        } else if (N - 1 - *students.rbegin() == dist && *students.rbegin() + dist != pos){
            pos = N - 1;
        } else if (N - 1 - *students.rbegin() == dist && *students.rbegin() + dist == pos) {

        } else if (N - 1 - *students.rbegin() > dist) {

        }
        else{
           if (*students.rbegin() < N -1 && N - 1 - *students.rbegin() >= dist){
                pos = N - 1;
            }
        }

        if (N - 1 - *students.rbegin() > dist){
             dist = N - 1 - *students.rbegin();
             pos = N - 1;
        }
        if (*students.rbegin() == N -1 ){

        }
        else {
            auto it = students.begin();
            while (next(it) != students.end()) {
            int d = (*next(it) - *it) / 2;
            if (d > dist) {
                dist = d;
                pos = *it + d;
            }
            it++;
        }
            if (N - 1 - *students.rbegin() > dist){
                dist = N - 1 - *students.rbegin();
                pos = N - 1;
            }
        }

        if(students.size() == 1 && N > 2) {

            if (N - 1 - *students.begin() > *students.begin()){
                pos = N - 1;
            }
            else if (N - 1 - *students.begin() == *students.begin()){
                pos = N - 1;
            }
        }
        if (students.size() == 1 && N == 2) {
            pos = 1;
        }

        it = students.begin();
        if (students.size() > 1){
            while (next(it) != students.end()) {
            int d = (*next(it) - *it) / 2;
            if (d > dist) {
                dist = d;
                pos = *it + d;
            }
            it++;
        }
        }

        if(students.size() > 0 && students.size() < N){
            if(N - 1 - *students.rbegin() > dist){
                pos = N - 1;
            }

        }

        if(students.size() == 1 && N == 1){
            pos = 0;
        }

        if(students.size() == 1 && N == 2 && *students.begin() == 0){
            pos = 1;
        }

        if(students.size() > 0 && students.size() < N){
             if(N - 1 - *students.rbegin() > dist){
                pos = N - 1;
            }
        }
        if(students.size() > 0 && students.size() < N){
              if (N - 1 - *students.rbegin() > dist){
                 pos = N - 1;
            }
        }

        if (N - 1 - *students.rbegin() > dist){
             pos = N - 1;
        }

        if (N - 1 - *students.rbegin() > dist){
            pos = N - 1;
        }

        if(students.size() > 0 && students.size() < N){
            if(N - 1 - *students.rbegin() > dist){
                pos = N - 1;
            }
        }

        students.insert(pos);
        return pos;
    }

    void leave(int p) {
        students.erase(p);
    }

private:
    int N;
    std::set<int> students;
};