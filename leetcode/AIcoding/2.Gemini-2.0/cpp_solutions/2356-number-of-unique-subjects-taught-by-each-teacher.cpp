#include <vector>
#include <unordered_map>

using namespace std;

```
```cpp

#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

```
```sql
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;