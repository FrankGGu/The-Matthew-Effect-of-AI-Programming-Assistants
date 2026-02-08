type MyHashMap struct {
	size int
	table []bucket
}

type bucket []pair

type pair struct {
	key, value int
}

func Constructor() MyHashMap {
	return MyHashMap{
		size: 1000,
		table: make([]bucket, 1000),
	}
}

func (this *MyHashMap) Put(key int, value int)  {
	h := this.hash(key)
	b := this.table[h]
	for i := range b {
		if b[i].key == key {
			b[i].value = value
			return
		}
	}
	this.table[h] = append(this.table[h], pair{key, value})
}

func (this *MyHashMap) Get(key int) int {
	h := this.hash(key)
	b := this.table[h]
	for i := range b {
		if b[i].key == key {
			return b[i].value
		}
	}
	return -1
}

func (this *MyHashMap) Remove(key int)  {
	h := this.hash(key)
	b := this.table[h]
	for i := range b {
		if b[i].key == key {
			this.table[h] = append(b[:i], b[i+1:]...)
			return
		}
	}
}

func (this *MyHashMap) hash(key int) int {
	return key % this.size
}