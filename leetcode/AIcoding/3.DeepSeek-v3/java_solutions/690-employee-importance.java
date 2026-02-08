class Solution {
    public int getImportance(List<Employee> employees, int id) {
        Map<Integer, Employee> map = new HashMap<>();
        for (Employee emp : employees) {
            map.put(emp.id, emp);
        }
        Queue<Employee> queue = new LinkedList<>();
        queue.offer(map.get(id));
        int totalImportance = 0;
        while (!queue.isEmpty()) {
            Employee current = queue.poll();
            totalImportance += current.importance;
            for (int subId : current.subordinates) {
                queue.offer(map.get(subId));
            }
        }
        return totalImportance;
    }
}