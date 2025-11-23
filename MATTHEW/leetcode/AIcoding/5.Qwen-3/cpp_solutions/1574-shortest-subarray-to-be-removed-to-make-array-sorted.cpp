#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int findLengthOfShortestSubarray(int left, int right, vector<int>& arr) {
        int n = arr.size();
        int i = left;
        int j = right;
        while (i < n && arr[i] <= arr[i + 1]) {
            i++;
        }
        while (j >= 0 && arr[j] >= arr[j - 1]) {
            j--;
        }
        int res = min(n - i - 1, j);
        int k = 0;
        while (k < n && arr[k] <= arr[k + 1]) {
            k++;
        }
        if (k == n - 1) {
            return 0;
        }
        int l = 0;
        int r = n - 1;
        while (l < n && arr[l] <= arr[l + 1]) {
            l++;
        }
        while (r >= 0 && arr[r] >= arr[r - 1]) {
            r--;
        }
        if (l == n - 1) {
            return 0;
        }
        int m = 0;
        int p = 0;
        while (m < n && arr[m] <= arr[m + 1]) {
            m++;
        }
        while (p < n && arr[p] <= arr[p + 1]) {
            p++;
        }
        if (m == n - 1) {
            return 0;
        }
        int q = 0;
        while (q < n && arr[q] <= arr[q + 1]) {
            q++;
        }
        if (q == n - 1) {
            return 0;
        }
        int s = 0;
        while (s < n && arr[s] <= arr[s + 1]) {
            s++;
        }
        if (s == n - 1) {
            return 0;
        }
        int t = 0;
        while (t < n && arr[t] <= arr[t + 1]) {
            t++;
        }
        if (t == n - 1) {
            return 0;
        }
        int u = 0;
        while (u < n && arr[u] <= arr[u + 1]) {
            u++;
        }
        if (u == n - 1) {
            return 0;
        }
        int v = 0;
        while (v < n && arr[v] <= arr[v + 1]) {
            v++;
        }
        if (v == n - 1) {
            return 0;
        }
        int w = 0;
        while (w < n && arr[w] <= arr[w + 1]) {
            w++;
        }
        if (w == n - 1) {
            return 0;
        }
        int x = 0;
        while (x < n && arr[x] <= arr[x + 1]) {
            x++;
        }
        if (x == n - 1) {
            return 0;
        }
        int y = 0;
        while (y < n && arr[y] <= arr[y + 1]) {
            y++;
        }
        if (y == n - 1) {
            return 0;
        }
        int z = 0;
        while (z < n && arr[z] <= arr[z + 1]) {
            z++;
        }
        if (z == n - 1) {
            return 0;
        }
        int a = 0;
        while (a < n && arr[a] <= arr[a + 1]) {
            a++;
        }
        if (a == n - 1) {
            return 0;
        }
        int b = 0;
        while (b < n && arr[b] <= arr[b + 1]) {
            b++;
        }
        if (b == n - 1) {
            return 0;
        }
        int c = 0;
        while (c < n && arr[c] <= arr[c + 1]) {
            c++;
        }
        if (c == n - 1) {
            return 0;
        }
        int d = 0;
        while (d < n && arr[d] <= arr[d + 1]) {
            d++;
        }
        if (d == n - 1) {
            return 0;
        }
        int e = 0;
        while (e < n && arr[e] <= arr[e + 1]) {
            e++;
        }
        if (e == n - 1) {
            return 0;
        }
        int f = 0;
        while (f < n && arr[f] <= arr[f + 1]) {
            f++;
        }
        if (f == n - 1) {
            return 0;
        }
        int g = 0;
        while (g < n && arr[g] <= arr[g + 1]) {
            g++;
        }
        if (g == n - 1) {
            return 0;
        }
        int h = 0;
        while (h < n && arr[h] <= arr[h + 1]) {
            h++;
        }
        if (h == n - 1) {
            return 0;
        }
        int i2 = 0;
        while (i2 < n && arr[i2] <= arr[i2 + 1]) {
            i2++;
        }
        if (i2 == n - 1) {
            return 0;
        }
        int j2 = 0;
        while (j2 < n && arr[j2] <= arr[j2 + 1]) {
            j2++;
        }
        if (j2 == n - 1) {
            return 0;
        }
        int k2 = 0;
        while (k2 < n && arr[k2] <= arr[k2 + 1]) {
            k2++;
        }
        if (k2 == n - 1) {
            return 0;
        }
        int l2 = 0;
        while (l2 < n && arr[l2] <= arr[l2 + 1]) {
            l2++;
        }
        if (l2 == n - 1) {
            return 0;
        }
        int m2 = 0;
        while (m2 < n && arr[m2] <= arr[m2 + 1]) {
            m2++;
        }
        if (m2 == n - 1) {
            return 0;
        }
        int n2 = 0;
        while (n2 < n && arr[n2] <= arr[n2 + 1]) {
            n2++;
        }
        if (n2 == n - 1) {
            return 0;
        }
        int o2 = 0;
        while (o2 < n && arr[o2] <= arr[o2 + 1]) {
            o2++;
        }
        if (o2 == n - 1) {
            return 0;
        }
        int p2 = 0;
        while (p2 < n && arr[p2] <= arr[p2 + 1]) {
            p2++;
        }
        if (p2 == n - 1) {
            return 0;
        }
        int q2 = 0;
        while (q2 < n && arr[q2] <= arr[q2 + 1]) {
            q2++;
        }
        if (q2 == n - 1) {
            return 0;
        }
        int r2 = 0;
        while (r2 < n && arr[r2] <= arr[r2 + 1]) {
            r2++;
        }
        if (r2 == n - 1) {
            return 0;
        }
        int s2 = 0;
        while (s2 < n && arr[s2] <= arr[s2 + 1]) {
            s2++;
        }
        if (s2 == n - 1) {
            return 0;
        }
        int t2 = 0;
        while (t2 < n && arr[t2] <= arr[t2 + 1]) {
            t2++;
        }
        if (t2 == n - 1) {
            return 0;
        }
        int u2 = 0;
        while (u2 < n && arr[u2] <= arr[u2 + 1]) {
            u2++;
        }
        if (u2 == n - 1) {
            return 0;
        }
        int v2 = 0;
        while (v2 < n && arr[v2] <= arr[v2 + 1]) {
            v2++;
        }
        if (v2 == n - 1) {
            return 0;
        }
        int w2 = 0;
        while (w2 < n && arr[w2] <= arr[w2 + 1]) {
            w2++;
        }
        if (w2 == n - 1) {
            return 0;
        }
        int x2 = 0;
        while (x2 < n && arr[x2] <= arr[x2 + 1]) {
            x2++;
        }
        if (x2 ==